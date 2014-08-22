class WorkerResource < VtrackApi
  class << self
    def shop
      find(:all, from: :shop)
    end

    def active
      find(:all, from: :active)
    end

    def missing
      find(:all, from: :missing)
    end

  end

  def sign_in
    post(:sign_in)
  end

  def sign_out
    post(:sign_out)
  end

end # class WorkerResource < VtrackApi
