class Api::ContactFormsController < Api::ApplicationController
  before_action :fetch_contact_forms, only: [:index]
  before_action :set_contact_form, only: [:show]
  protect_from_forgery

  def index
    render json: ContactFormBasicSerializer.new(@contact_forms, { params: serializer_params, include: includes, meta: pagination_meta(@contact_forms)}), status: :ok
  end

  def show
    if @contact_form
      render json: ContactFormSerializer.new(@contact_form, { params: serializer_params, include: includes }), status: :ok
    else
      render json: serialize_errors(@contact_form), status: :unprocessable_entity
    end
  end

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

  def set_contact_form
    @contact_form = ContactForm.find(params[:id])
  end

  def fetch_contact_forms
    @contact_forms = ContactForm.all.order(sort_params).page(page_param).per_page(per_page_param)
  end
end
