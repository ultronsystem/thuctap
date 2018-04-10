module Admin
  class UsersController < AdminController
    before_action :find_user, only: %i(edit update destroy)

    def index
      @users = User.paginate page: params[:page], per_page: Settings.users.page_size
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params
      if @user.save
        flash[:success] = t ".new_create"
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update_attributes user_params
        flash[:success] = "Cập nhập thành công"
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      if @user.destroy
        flash[:success] = "Xóa thành công"
      else
        flash[:danger] = "Xóa thất bại"
      end
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit :fullname, :email, :password, :password_confirmation
    end

    def find_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = "Không tìm thấy tài khoản"
      redirect_to admin_users_path
    end
  end
end
