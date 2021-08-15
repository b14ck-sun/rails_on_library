class CreditCollectorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # puts "I am Kewl"
    for rec in Borrow.all
      if rec.state == "borrowed"
        # cst = rec.user.Debt + rec.book.costs
        if rec.user.Debt then cst = rec.user.Debt - rec.book.cost else cst = - rec.book.cost end
        # puts cst
        rec.user.update(Debt: cst)
        # puts rec.book.cost
      end
    end
  end
end

# Sidekiq::Cron::Job.create(name: 'Debt Collecter - every min', cron: '*/1 * * * *', class: 'CreditCollectorJob')
