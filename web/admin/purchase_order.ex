defmodule ContactDemo.ExAdmin.PurchaseOrder do
  use ExAdmin.Register

  alias ContactDemo.{Auditable, PurchaseOrder}

  register_resource ContactDemo.PurchaseOrder do
    menu priority: 2

    filter except: [:currency_exchange_rate, :profit_percentage, :inserted_at, :updated_at]

    index do
      selectable_column

      column :placed_on
      column :name
      # TODO: Use the 'ExAdmin.Render' for uniformly handling this. See: https://github.com/smpallen99/ex_admin/issues/183
      # TODO: Need to figure out how to sort by this column (https://github.com/smpallen99/ex_admin/issues/48)
      column :buying_price
      column :currency_code

      actions
    end

    csv [
      :placed_on,
      :name,
      :currency_code,
      :buying_price,
    ]

    controller do
      before_filter :capture_audit_settings, only: [:create, :update, :delete]

      def capture_audit_settings(conn, params), do: Auditable.capture_audit_settings(conn, params)
    end

    changesets create: &Auditable.audited_changeset/2,
               update: &Auditable.audited_changeset/2,
               delete: &Auditable.audited_changeset/2

    form purchase_order do
      inputs do
        # TODO: Fix this render when there is data
        # input purchase_order, :placed_on
        input purchase_order, :name
        input purchase_order, :currency_code
        input purchase_order, :buying_price
      end
    end

    show purchase_order do
      attributes_table do
        row :placed_on
        row :name
        row :currency_code
        # TODO: Use the 'ExAdmin.Render' for uniformly handling this. See: https://github.com/smpallen99/ex_admin/issues/183
        row :buying_price
      end
    end

    query do
      %{
        index: [default_sort: [desc: :placed_on]]
      }
    end
  end
end
