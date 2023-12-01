class SharesController < ApplicationController
  def index
    @shares = Share.all # Получение списка всех акций
  end

  def new
    @share = Share.new # Создание нового экземпляра акции
  end

  def create
    @share = Share.new(share_params) # Создание новой акции с переданными параметрами

    if @share.save
      redirect_to shares_path, notice: 'Акция успешно создана.' # Перенаправление на страницу списка акций с сообщением об успехе
    else
      render :new
    end
  end

  private

def share_params
  params.permit(:name, :cost) # Удаляем .require(:share)
end
end