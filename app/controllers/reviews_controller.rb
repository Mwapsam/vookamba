class ReviewsController < ApplicationController
    before_action :find_company
    before_action :find_review, only: [:edit, :update, :destroy]

    def new
        @review = Review.new
    end

    def create
        @user = current_user
        @review = Review.new(review_params)
        @review.company_id = @company.id 
        @review.user_id = @user.id

        if @review.save
            redirect_to company_path(@company.id), notice: "The review has been added successfully!"
        else
            render :new, alert: 'Error please try again later!'
        end
    end

    def edit
    end

    def update
        if @review.update(review_params)
            redirect_to company_path(@company)
        else
            render :edit, alert: 'Error please try again later!'
        end
    end

    def destroy
        @review.destroy
        respond_to do |format|
            format.html { redirect_to company_path(@company), alert: 'You have successfully deleted the review!' }
        end
    end

    private 
     def review_params
        params.require(:review).permit(:rating, :comment)
     end

     def find_company
        @company = Company.find(params[:company_id])
     end

     def find_review
        @review = Review.find(params[:id])
     end
end
