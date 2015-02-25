class ErrorsController < ActionController::Base
  # layout to show with your errors. make sure it's not that fancy because we're
  # handling errors.
  layout 'application'

  def show
    @exception  = env['action_dispatch.exception']
    @status     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code

    # @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    # response contains the error name ex: 404 => "not found"
    render status: @status
  end
end
