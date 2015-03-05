class ExecsController < InheritedResources::Base

  private

    def exec_params
      params.require(:exec).permit(:exec_name, :team, :responsibilities, :program)
    end
end

