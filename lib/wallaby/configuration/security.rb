class Wallaby::Configuration::Security
  # by default, current_user returns nil
  DEFAULT_CURRENT_USER  = -> {}
  # by default, authenticate returns true not to stop the before_action chain
  DEFAULT_AUTHENTICATE  = -> { true }

  def current_user(&block)
    if block_given?
      @current_user = block
    else
      @current_user ||= DEFAULT_CURRENT_USER
    end
  end

  def authenticate(&block)
    if block_given?
      @authenticate = block
    else
      @authenticate ||= DEFAULT_AUTHENTICATE
    end
  end
end