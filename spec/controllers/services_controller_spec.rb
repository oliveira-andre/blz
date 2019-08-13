# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::ServicesController, type: :controller do
  describe 'index service' do
    context 'when user is not authenticated' do
      it 'redirect to sign in' do
        get :index, params: { establishment_id: 0 }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated and not a establishment' do
      let(:establishment) { create(:establishment_with_services) }

      it 'show error message and redirect to home page' do
        establishment = create(:establishment)

        sign_in create(:user)

        get :index, params: { establishment_id: establishment.id }

        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authenticated and a establishment' do
      it 'show only your services and render index template' do
        establishment = create(:establishment_with_services)
        create_list(:service, 10)

        sign_in establishment.user

        get :index, params: { establishment_id: establishment.id }

        current_services_ids = assigns(:services).ids
        expect(current_services_ids).to eq(establishment.services.ids)
        expect(response).to render_template(:index)
      end
    end

    context 'when try access services of the other establishment' do
      it 'redirect to root page with erro message' do
        establishment = create(:establishment)
        other_establishment = create(:establishment)

        sign_in establishment.user

        get :index, params: { establishment_id: other_establishment.id }

        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'show service' do
    context 'when service_id sended is approved' do
      it 'render show page with right service' do
        service = create(:service)

        get :show, params: { id: service.id }

        expect(assigns(:service).id).to eq(service.id)
        expect(response).to render_template(:show)
      end
    end

    context 'when service_id sended is not approved' do
      it 'show error message and redirect to home page' do
        service = create(:service, :not_approved)

        get :show, params: { id: service.id }

        expect(flash[:error]).to eq('Serviço não encontrado!')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'new service' do
    context 'when user is not authenticated' do
      it 'redirect to sign in' do
        get :new, params: { establishment_id: 0 }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated and is a establishment' do
      let(:establishment) { create(:establishment) }

      before do
        sign_in establishment.user
        get :new, params: { establishment_id: establishment.id }
      end

      it 'render new template service' do
        expect(response).to render_template(:new)
      end

      it 'create @service variable associated to current establishment' do
        expect(assigns(:service).establishment_id).to eq(establishment.id)
      end
    end

    context 'when user is a other establishment' do
      it 'redirect to root page with erro message' do
        establishment = create(:establishment)
        other_establishment = create(:establishment)

        sign_in establishment.user

        get :new, params: { establishment_id: other_establishment.id }

        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authenticated and is not a establishment' do
      it 'redirect to home page and show message error' do
        establishment = create(:establishment)
        sign_in create(:user)

        get :new, params: { establishment_id: establishment.id }
        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'create service' do
    context 'when user is not authenticated' do
      it 'redirect to sign in' do
        post :create, params: { establishment_id: 0, service: {} }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated and is not a establishment' do
      it 'redirect to home page and show message error' do
        establishment = create(:establishment)
        sign_in create(:user)

        post :create, params: {
          establishment_id: establishment.id,
          service: {}
        }

        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user establishment is right' do
      context 'and all service params is right' do
        let(:establishment) { create(:establishment) }
        let(:service_params) do
          attributes_for(:service, establishment_id: establishment.id)
        end

        before do
          sign_in establishment.user

          post :create, params: {
            establishment_id: establishment.id,
            service: service_params
          }

          establishment.reload
        end

        it 'then is created right service' do
          service = assigns(:service)

          expect(service.id).not_to be_nil
          expect(service.title).to eq(service_params[:title])
          expect(service.local_type).to eq(service_params[:local_type])
          expect(service.amount).to eq(service_params[:amount])
          expect(service.duration).to eq(service_params[:duration])
          expect(service.category_id).to eq(service_params[:category_id])
          expect(service.description)
            .to eq(service_params[:description])
        end

        it 'redirect to edit page with success message' do
          service = assigns(:service)

          expect(response).to redirect_to(
            edit_establishment_service_path(
              establishment, service, anchor: :professional_services
            )
          )

          expect(flash[:notice]).to include('Serviço criado com sucesso')
        end
      end

      context 'and service params required are not present' do
        it 'stay in same page with errors messages' do
          establishment = create(:establishment)
          sign_in establishment.user

          post :create, params: {
            establishment_id: establishment.id,
            service: { title: '' }
          }

          service = assigns(:service)
          errors = service.errors.full_messages

          expect(response).to render_template(:new)
          expect(errors).to include('Categoria é obrigatório(a)')
          expect(errors).to include('Título não pode ficar em branco')
          expect(errors).to include('Descrição não pode ficar em branco')
          expect(errors).to include('Valor não pode ficar em branco')
          expect(errors).to include('Duração não pode ficar em branco')
          expect(errors)
            .to include('Localidade do Serviço não pode ficar em branco')
        end
      end

      context 'and service title already exist in the establishment' do
        it 'stay in same page and show error uniqueness title message' do
          establishment = create(:establishment)
          other_service = create(:service, establishment: establishment)
          service_params = attributes_for(
            :service,
            title: other_service.title,
            establishment_id: establishment.id
          )

          sign_in establishment.user

          post :create, params: {
            establishment_id: establishment.id,
            service: service_params
          }

          service = assigns(:service)
          errors = service.errors.full_messages

          expect(response).to render_template(:new)
          expect(errors).to include('Título já está em uso')
        end
      end
    end
  end

  describe 'destroy service' do
    context 'when user is authenticated and owner of service' do
      let(:service) { create(:service) }

      before do
        sign_in service.establishment.user

        delete :destroy, params: {
          establishment_id: service.establishment.id,
          id: service.id
        }
      end

      it 'show notice message and redirect to dashboard' do
        expect(flash[:notice]).to eq('Serviço arquivado!')
        expect(response).to redirect_to(
          establishments_dashboard_path(service.establishment)
        )
      end

      it 'update service to archived' do
        service.reload
        expect(service.status).to eq('archived')
      end
    end

    context 'when user is authenticated, but is not owner of service' do
      it 'show error message and redirect to home page' do
        service = create(:service)
        sign_in create(:user)

        delete :destroy, params: {
          establishment_id: service.establishment.id,
          id: service.id
        }

        expect(response).to have_http_status(:found)
        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        delete :destroy, params: { establishment_id: 0, id: 0 }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end
  end

  describe 'edit service' do
    context 'when user is not logged in' do
      it 'show error and redirect to sign_in page' do
        service = create(:service)
        get :edit, params: {
          establishment_id: service.establishment_id,
          id: service.id
        }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is logged in' do
      context 'when user is blocked' do
        it 'show error and redirect to root_path' do
          service = create(:service)
          sign_in create(:blocked_user)
          get :edit, params: {
            establishment_id: service.establishment_id,
            id: service.id
          }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root_path' do
          service = create(:service)
          sign_in create(:user)
          get :edit, params: {
            establishment_id: service.establishment_id,
            id: service.id
          }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when try to access service of another estabishment' do
        it 'show error and redirect to root_path' do
          service = create(:service)
          another_service = create(:service)
          sign_in service.establishment.user
          get :edit, params: {
            establishment_id: another_service.establishment_id,
            id: another_service.id
          }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when try to access self service' do
        it 'render template edit and show page with success' do
          service = create(:service)
          sign_in service.establishment.user
          get :edit, params: {
            establishment_id: service.establishment_id,
            id: service.id
          }
          expect(response).to have_http_status(:successful)
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'update service' do
    context 'when user is not logged in' do
      it 'show error and redirect to sign_in page' do
        service = create(:service)
        patch :update, params: {
          establishment_id: service.establishment_id,
          id: service.id,
          service: {
            description: FFaker::Lorem.sentence
          }
        }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is logged in' do
      context 'when user is blocked' do
        it 'show error and redirect to root_path' do
          service = create(:service)
          sign_in create(:blocked_user)
          patch :update, params: {
            establishment_id: service.establishment_id,
            id: service.id,
            service: {
              description: FFaker::Lorem.sentence
            }
          }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root_path' do
          service = create(:service)
          sign_in create(:user)
          patch :update, params: {
            establishment_id: service.establishment_id,
            id: service.id,
            service: {
              description: FFaker::Lorem.sentence
            }
          }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when is a establishment' do
        context 'when try to update a service of another establishment' do
          it 'show error and redirect to root_path' do
            service = create(:service)
            another_service = create(:service)
            sign_in service.establishment.user
            patch :update, params: {
              establishment_id: another_service.establishment_id,
              id: another_service.id,
              service: {
                description: FFaker::Lorem.sentence
              }
            }
            expect(flash[:error]).to eq('Não autorizado')
            expect(response).to redirect_to(root_path)
          end
        end

        context 'when try to update self service' do
          context 'trying to update fields that cant be updated' do
            it 'show error messages and stay in the same page' do
              service = create(:service_awating_avaliation)
              another_service = create(:service)
              sign_in service.establishment.user
              patch :update, params: {
                establishment_id: service.establishment_id,
                id: service.id,
                service: {
                  title: another_service.title,
                  status: 'approved'
                }
              }
              expect(assigns(:service).errors.full_messages).to include(
                'Serviço não pode ser aprovado sem profissionais com agenda.'
              )
            end
          end

          context 'when update the fields that can be updated' do
            it 'update with success and stay in the same page' do
              service = create(:service_awating_avaliation)
              sign_in service.establishment.user
              patch :update, params: {
                establishment_id: service.establishment_id,
                id: service.id,
                service: {
                  description: 'teste'
                }
              }
              expect(flash[:notice]).to eq('Serviço atualizado com sucesso')
              expect(response).to redirect_to(
                establishment_services_pt_br_path(
                  establishment_id: service.establishment_id
                )
              )
            end
          end
        end
      end
    end
  end
end
