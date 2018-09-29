class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:edit, :update, :show, :destroy]
  access all: [:show, :index], user: {except: [:sort, :destroy, :new, :create, :edit, :update]}, site_admin: :all
  layout "portfolio"

  def index
    @portfolio_items = Portfolio.by_position
  end

  def show
  end

  def sort
    params[:orders].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    head :ok
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html {redirect_to portfolios_path, notice: 'Created'}
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'Portfolio item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @portfolio_item.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
    end
  end

  private

  def set_portfolio
    @portfolio_item = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:title, :body, :subtitle,
                                      :main_image, :thumb_image,
                                      technologies_attributes: [:name, :id, :_destroy])
  end

end
