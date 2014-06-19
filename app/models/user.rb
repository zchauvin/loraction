class User < ActiveRecord::Base
  has_many :contracts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name 
  	self.first_name + " " + self.last_name
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.nickname
      user.oauth_token = auth.credentials.token
    end
  end

  def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.send_emails 
    all.each do |user| 
      user.contracts.each do |contract|
        if (Date.today - contract.created_at.to_date).to_i % Level.time_to_int(contract.level.timescale) == 0
          UserMailer.report_email(user, contract).deliver
        end  
      end
    end
  end

  def facebook 
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end


  
end
