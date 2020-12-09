class Administrator < ApplicationRecord

  devise(
    # :confirmable,
    :database_authenticatable,
    # :lockable,
    # :omniauthable,
    :recoverable,
    :registerable,
    :rememberable,
    # :timeoutable,
    :trackable,
    :validatable
    )


  def current_sign_in_date
    if current_sign_in_at
      current_sign_in_at.strftime('%Y-%m-%d')
    end
  end


  def current_sign_in_time
    if current_sign_in_at
      current_sign_in_at.strftime('%H:%M:%S %z')
    end
  end


  def display_name
    name || email
  end


  def does_have_authority_to_write
    has_authority_to_write == true
  end


  def does_not_have_authority_to_write
    has_authority_to_write != true
  end


  ### email


  ### has_authority_to_write


  def last_sign_in_date
    if last_sign_in_at
      last_sign_in_at.strftime('%Y-%m-%d')
    end
  end


  def last_sign_in_time
    if last_sign_in_at
      last_sign_in_at.strftime('%H:%M:%S %z')
    end
  end


  ### name



end
