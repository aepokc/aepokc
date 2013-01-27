class PaymentsController < ApplicationController
  protect_from_forgery :except => [:create]
	before_filter :authenticate_admin!, :except => [:dues, :mail, :cancelled, :processed, :create]
	before_filter :authenticate_member!, :only => [:dues]
	layout 'admin'
	
	def dues
		render :layout => 'profiles'
	end
	
	def mail
	  render :layout => 'profiles'
	end
	
	def cancelled
		render :layout => 'profiles'
	end
	
	def processed
		render :layout => 'profiles'
	end
	
  def index
    @progress = Payment.current_count/Member.count.to_f*100
    @payments = Payment.find :all, :order => 'date desc'
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def create
    @payment = Payment.new(params[:payment])
    if params[:invoice]
      @payment.source = "PayPal"
      @payment.member_id = params[:invoice]
      @payment.amount = params[:mc_gross]
      @payment.date = Date.today
    end
    if @payment.save
      Receipt.mail_to_payer(@payment).deliver
      if @payment.source=="PayPal"
        render :nothing => true
      else
        redirect_to(@payment, :notice => 'Payment was successfully recorded.')
      end
    else
      render :action => "new"
    end
  end

  def update
    @payment = Payment.find(params[:id])

    if @payment.update_attributes(params[:payment])
      redirect_to(@payment, :notice => 'Payment was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    redirect_to(payments_url)
  end
end