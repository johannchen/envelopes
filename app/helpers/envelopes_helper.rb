module EnvelopesHelper
  def amount_percentage(envelope)
    if envelope.budget == 0 or envelope.current_amount <= 0
      "0.00%"
    else
      number_to_percentage(envelope.current_amount / envelope.budget * 100, :precision => 2)
    end
  end
end
