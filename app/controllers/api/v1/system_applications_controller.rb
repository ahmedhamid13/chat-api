class Api::V1::SystemApplicationsController < Api::V1::ApiController
  include Api::V1::SystemApplication
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /api/v1/applications
  def index
    @pagy, @applications = pagy(::SystemApplication.all)

    render json: { applications: applications_json(@applications, @includes), pagy: pagy_json(@pagy, @includes) }
  end

  # GET /api/v1/applications/1
  def show
    render json: application_json(@application, @includes)
  end

  # POST /api/v1/applications
  def create
    @application = ::SystemApplication.new(application_params)

    if @application.save
      render json: application_json(@application, @includes), status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/applications/1
  def update
    if @application.update(application_params)
      render json: application_json(@application, @includes)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = ::SystemApplication.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end
