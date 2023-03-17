# every 10th day of month at 02:00 UTC, Indonesia 10:00
every "0 2 10 * *" do
  runner "SendReminderToPayTaxes.call"
end

# every tuesday and friday at 02:00 UTC, Indonesia 10:00
every "0 2 * * 2,5" do
  runner "SendMessageToBotToAskIfKomankCameToday.call"
end
