defmodule DeGymAppWeb.Router do
  use DeGymAppWeb, :router

  import DeGymAppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DeGymAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DeGymAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    #live "/live", Live
    #get "/trainingplans/add_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :add_exercise
    #get "/trainingplans/delete_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :delete_exercise
    #resources("/employees", EmployeeController)
    #resources("/clients", ClientController)
    #resources("/tools", ToolController)
    #resources("/trainingplans", TrainingplanController)
    #delete "/trainingplans/remove_exercise/:training_id/:exercise_id", TrainingplanController, :delete_exercise
    #patch "/trainingplans/add_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :add_exercise
    #resources("/exercises", ExerciseController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DeGymAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      #live "/live", DeGymAppWeb.Live
      live_dashboard "/dashboard", metrics: DeGymAppWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DeGymAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update



  end

  scope "/", DeGymAppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    #paths
    live "/trainingplans/live", TrainingOverviewLive
    live "/live", Live
    get "/trainingplans/add_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :add_exercise
    get "/trainingplans/delete_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :delete_exercise
    get "/clients/add_trainingplan/:client_id/:trainingplan_id", ClientController, :add_trainingplan
    get "/clients/remove_trainingplan/:client_id/:trainingplan_id", ClientController, :remove_trainingplan
    get "/clients/add_employee/:client_id/:employee_id", ClientController, :add_employee
    #get "/clients/remove_employee/:client_id/:employee_id", ClientController, :remove_employee

    resources("/employees", EmployeeController)
    resources("/clients", ClientController)
    #resources("/tools", ToolController)
    resources("/trainingplans", TrainingplanController)
    delete "/trainingplans/remove_exercise/:training_id/:exercise_id", TrainingplanController, :delete_exercise
    patch "/trainingplans/add_exercise/:trainingplan_id/:exercise_id", TrainingplanController, :add_exercise
    resources("/exercises", ExerciseController)
  end

  scope "/", DeGymAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
