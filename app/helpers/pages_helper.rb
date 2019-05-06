module PagesHelper
  def liner_gradiente_card_img(photo_url)
    "background: -moz-linear-gradient(rgba(42, 197, 204, 0.2), rgba(42, 197, 204, 0.4), rgba(28, 130, 136, 0.87)), url('#{photo_url}');
    background: -webkit-linear-gradient(rgba(42, 197, 204, 0.2), rgba(42, 197, 204, 0.4), rgba(28, 130, 136, 0.87)), url('#{photo_url}');
    background: -ms-linear-gradient(rgba(42, 197, 204, 0.2), rgba(42, 197, 204, 0.4), rgba(28, 130, 136, 0.87)), url('#{photo_url}');
    background: linear-gradient(rgba(42, 197, 204, 0.2), rgba(42, 197, 204, 0.4), rgba(28, 130, 136, 0.87)), url('#{photo_url}');"
  end
end
