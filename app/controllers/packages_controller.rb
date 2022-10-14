class PackagesController < ApplicationController
    def index
        @packages = Package.all
    end

    def new
        @package = Package.new
    end

    def create
        @user = current_user
        @package = @user.packages.new(package_params)
        if @package.save
            redirect_to packages_path, notice: "Package successfully created"
        else
            render :new, alert: 'Error please try again later!'
        end
    end

    def edit
        @package = Package.find(params[:id])
        if @package.update(package_params)
            redirect_to package_path(@package.id), notice: "Package successfully updated"
        else
            render :new, alert: 'Error please try again later!'
        end
    end

    private

    def package_params
        params.require(:package).permit(:title, :description, :price)
    end
end
