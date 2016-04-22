class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :time_request

  # Prevents these methods from being invoked from a route
  protected

  def time_request
    start = Time.now
    yield
    elapsed = ((Time.now - start) * 1_000).round
    logger.highlight("Resquest took #{elapsed}ms to complete")
  end
end
