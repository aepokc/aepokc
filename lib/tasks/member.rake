namespace :members do
  task :invoice => :environment do
    Member.where(active: true).each do |m|
      if !m.is_current
        # sent first invoice on confirmed_at
        if m.has_balance
          outstanding = m.invoices.last
          if outstanding.updated_at<1.month.ago
            if m.due_date<1.year.ago.to_date
              # prevent seventh invoice at day 371
              m.active = false
              m.save
              p 'Deactivated '+m.full_name
            else
              if m.invoiced_at<(outstanding.send_count).months.ago.to_date
                # send second invoice at day 31
                # send third invoice at day 91
                # send fourth invoice at day 121
                # send fifth invoice at day 151
                # send sixth invoice at day 221
                m.invoice(20)
                p 'Invoicing '+m.full_name
                sleep 2
              end
            end
          end
        else
          # send first invoice at day 1
          m.invoice(20)
          p 'Invoicing '+m.full_name
          sleep 2
        end
      end
    end
  end

  task :remind => :environment do
    Member.where(confirmed_at: nil).each do |m|
      if ((m.created_at.to_date-Date.today).to_f % 30) == 0
        MemberMailer.send_confirmation(m).deliver
        sleep 2
        p 'Sent confirmation reminder to '+m.full_name
      end
    end
  end
end
