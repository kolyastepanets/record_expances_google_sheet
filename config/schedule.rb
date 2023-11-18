# every 10th day of month at 02:00 UTC, Indonesia 10:00
every "0 2 10 * *" do
  runner "SendReminderToPayTaxes.call"
end

# every tuesday and friday at 02:00 UTC, Indonesia 10:00
every "0 2 * * 2,5" do
  runner "SendMessageToBotToAskIfKomankCameToday.call"
end

every 2.minutes do
  command "bash -c 'response=$(curl --write-out '%{http_code}' --silent --output /dev/null https://google-sheet-expenses-tg-bot.pp.ua/health_checks); if [ $response -eq 200 ]; then cd /home/root/apps/record_expenses_google_sheet/current && ~/.rvm/bin/rvm default do bundle exec pumactl -S /home/root/apps/record_expenses_google_sheet/shared/tmp/pids/puma.state -F /home/root/apps/record_expenses_google_sheet/shared/puma.rb restart; fi'"
end
