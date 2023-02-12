# every 10th day of month at 18:00
every "0 18 10 * *" do
  runner "SendReminderToPayTaxes.call"
end

# test
every "0 18 10 * *" do
  runner "SendReminderToPayTaxes.call"
end
