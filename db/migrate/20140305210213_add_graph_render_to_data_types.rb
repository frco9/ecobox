class AddGraphRenderToDataTypes < ActiveRecord::Migration
  def change
    add_column :data_types, :graph_render, :string
  end
end
