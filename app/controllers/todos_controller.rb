class TodosController < ApplicationController
  before_action :authorized
  before_action :set_user_id
  before_action :set_todo, only: %i[ update destroy ]

  # POST /todos
  def create
    project = Project.find(todo_params[:project_id])

    if project.user_id != @user_id
      return render json: { status: 'error' }, status: :unauthorized
    end

    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private
    def set_user_id
      @user_id = authorized.fetch('user_id')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])

      project = Project.find(@todo.project_id)

      if project.user_id != @user_id
        render json: { status: 'error' }, status: :unauthorized
      end
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:id, :text, :is_completed, :project_id)
    end
end
