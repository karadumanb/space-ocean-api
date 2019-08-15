class Api::ContactFormsController < Api::ApplicationController
  protect_from_forgery

  def create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.save
      render json: {}, status: :ok
    else
      render json: serialize_errors(@contact_form), status: :unprocessable_entity
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:title, :body, :name, :email)
  end
end
