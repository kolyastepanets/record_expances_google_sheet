# every 10th day of month at 02:00 UTC, Indonesia 10:00
every "0 2 10 * *" do
  runner "SendReminderToPayTaxes.call"
end

# every tuesday and friday at 02:00 UTC, Indonesia 10:00
every "0 2 * * 2,5" do
  runner "SendMessageToBotToAskIfKomankCameToday.call"
end

every 2.minutes do
  command "bash -c 'response=$(curl --write-out '%{http_code}' --silent --output /dev/null https://google-sheet-expenses-tg-bot.pp.ua/health_checks); if [ $response -ne 200 ]; then mkdir -p /home/root/apps/record_expenses_google_sheet/shared/tmp/sockets && mkdir -p /home/root/apps/record_expenses_google_sheet/shared/tmp/pids && cd /home/root/apps/record_expenses_google_sheet/current && ~/.rvm/bin/rvm default do bundle exec puma -C /home/root/apps/record_expenses_google_sheet/shared/puma.rb --daemon; fi'"
end
