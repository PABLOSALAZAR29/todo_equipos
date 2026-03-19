# app/controllers/perfils_controller.rb
class PerfilsController < ApplicationController
  before_action :set_perfil, only: [:edit, :update]

  def show
    @perfil = Current.user.perfil || Perfil.new
  end

  def edit
     # Si tiene perfil lo carga, si no crea uno nuevo vacío
    @perfil = Current.user.perfil || Current.user.build_perfil
  end

  def update
    @perfil = Current.user.perfil || Current.user.build_perfil
    if @perfil.update(perfil_params)
      redirect_to perfil_path, notice: "Perfil actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @perfil = Current.user.build_perfil(perfil_params)
    if @perfil.save
      redirect_to perfil_path, notice: "Perfil creado correctamente."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_perfil
    @perfil = Current.user.perfil
  end

  def perfil_params
    params.require(:perfil).permit(
      :primer_nombre, :segundo_nombre,
      :primer_apellido, :segundo_apellido,
      :cedula,
      :foto,
      :celular, :ciudad, :departamento,
      :direccion, :cargo
    )
  end
end