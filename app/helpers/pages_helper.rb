# frozen_string_literal: true

module PagesHelper
  def liner_gradiente_card_img(photo_url)
    "background: -moz-linear-gradient(rgba(231, 231, 231, 0.2), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.87)), url('#{photo_url}');
    background: -webkit-linear-gradient(rgba(231, 231, 231, 0.2), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.87)), url('#{photo_url}');
    background: -ms-linear-gradient(rgba(231, 231, 231, 0.2), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.87)), url('#{photo_url}');
    background: linear-gradient(rgba(231, 231, 231, 0.2), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.87)), url('#{photo_url}');"
  end

  def liner_gradiente_card_img_dashboard_user(photo_url)
    "background: -moz-linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url('#{photo_url}');
    background: -webkit-linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url('#{photo_url}');
    background: -ms-linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url('#{photo_url}');
    background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url('#{photo_url}');"
  end
end
