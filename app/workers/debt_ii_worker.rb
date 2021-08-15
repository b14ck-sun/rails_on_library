class DebtIiWorker
  include Sidekiq::Worker

  def perform(*args)
    for rec in Borrow.all
      if rec.state == "borrowed"
        cst = rec.user.debt - rec.book.cost
        rec.user.update(debt: cst)
      end
    end
  end
end
