# frozen_string_literal: true

RSpec.describe SchedulingStatusController, type: :controller do
  describe 'nonexistent status error' do
    let(:scheduling) { FactoryBot.create(:scheduling) }

    context "try to access a nonexistent status" do
      it 'show error and stay in the same page' do
        sign_in scheduling.professional_service.service.establishment.user
        patch :update, params: { 
          scheduling_id: scheduling.id,
          status: :finalized
        }
        expect(flash[:alert]).to eq(
          'Status não encontrado'
        )
        expect(response).to redirect_to(
          establishments_dashboard_pt_br_path(
            scheduling.professional_service.service.establishment
          )
        )
      end
    end
  end

  describe 'accept scheduling' do
    let(:scheduling) { FactoryBot.create(:scheduling) }

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        patch :update, params: { scheduling_id: scheduling.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in FactoryBot.create(:blocked_user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root_path' do
          sign_in scheduling.user
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user don't have relation with scheduling" do
        it 'show error and redirect to root_path' do
          sign_in FactoryBot.create(:user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when is establishment user and try to accept' do
        it 'accept with success' do
          sign_in scheduling.professional_service.service.establishment.user
          patch :update, params: {
            scheduling_id: scheduling.id,
            status: :scheduled
          }
          expect(flash[:success]).to eq('Aceito com sucesso')
          expect(response).to redirect_to(
            establishments_dashboard_pt_br_path(
              scheduling.professional_service.service.establishment
            )
          )
        end
      end
    end
  end

  describe 'recuse scheduling' do
    let(:scheduling) { FactoryBot.create(:scheduling) }

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        patch :update, params: { scheduling_id: scheduling.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in FactoryBot.create(:blocked_user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root_path' do
          sign_in scheduling.user
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user don't have relation with scheduling" do
        it 'show error and redirect to root_path' do
          sign_in FactoryBot.create(:user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when is establishment user and try to recuse' do
        it 'recuse with success' do
          sign_in scheduling.professional_service.service.establishment.user
          patch :update, params: {
            scheduling_id: scheduling.id,
            status: :recused
          }
          expect(flash[:success]).to eq('Recusado com sucesso')
          expect(response).to redirect_to(
            establishments_dashboard_pt_br_path(
              scheduling.professional_service.service.establishment
            )
          )
        end
      end
    end
  end

  describe 'finalize scheduling' do
    let(:scheduling) { FactoryBot.create(:scheduling) }

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        patch :update, params: { scheduling_id: scheduling.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in FactoryBot.create(:blocked_user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root_path' do
          sign_in scheduling.user
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user don't have relation with scheduling" do
        it 'show error and redirect to root_path' do
          sign_in FactoryBot.create(:user)
          patch :update, params: { scheduling_id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when is establishment user and try to finish' do
        context 'establishment user try to finish before the scheduling date' do
          it 'show error staying in the same page' do
            travel_to scheduling.date - 1.hour
            sign_in scheduling.professional_service.service.establishment.user
            patch :update, params: {
              scheduling_id: scheduling.id,
              status: :finished
            }
            expect(flash[:error]).to eq(
              'Agendamento não pode ser finalizado antes a data combinada'
            )
            expect(response).to redirect_to(
              establishments_dashboard_pt_br_path(
                scheduling.professional_service.service.establishment
              )
            )
          end
        end

        context 'when the date is after the scheduling date' do
          it 'finalize with success and show successs' do
            travel_to scheduling.date + 1.hour
            sign_in scheduling.professional_service.service.establishment.user
            patch :update, params: {
              scheduling_id: scheduling.id,
              status: :finished
            }
            expect(flash[:success]).to eq('Finalizado com sucesso')
            expect(response).to redirect_to(
              establishments_dashboard_pt_br_path(
                scheduling.professional_service.service.establishment
              )
            )
          end
        end
      end
    end
  end
end
