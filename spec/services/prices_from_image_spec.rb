require 'rails_helper'

RSpec.describe PricesFromImage do
  subject { described_class.call(message_params) }

  let(:message_params) do
  end

  context 'when invalid parse' do
    invalid_parse = "PSICUTTER\nwon Road\n\nComberton\n\nCambridge €B23. 7hp\n\nKIKKOMAN TERIYAKI MARINA 3.00\nELMLEA DOUBLE 1.6/\nGROCERY NON VAT eed)\nGROCERY NON VAI 2.89\nGROCERY NON VAT 0.99\nGROCERY NON VAI 1.69\n\nSub-total 6 items 12.53\n\nAmount to pay 12.53\nPayment by CREDIT CARD 12.53\nChange\n\nshopping al\nhank you for shopping\nThank you ey cosTCurren\n"

    it 'return 3 values' do
    end
  end

  context 'when valid parse' do
    valid_parse = "HH\n\nPolish Marke Jess\n\n“we 72 Newmarket Road,\nCambridge,\n\nCB5 8DZ\nVAT NO: RECEIPT : 139506\nBR: 1\\1 Sobieslaw 20/08/2022 13:25\nMASLO POLSKIE 200G M £2.99\nCZEKOLADA ORZECHOWA £1.50\nTWAROG TLUSTY 250G MLEKPOL MAZURSKI SMAK\n! 2 @ 1.50 £3.00\nKASZA JECZMIENNA SRE £1.35\nKASZA GRYCZANA 400G £2.95\n\n£0.55\n£3.78\n£1.50\n£2.29\n£4.04\n\nTotal :£23.95\n\nCash:£23.95\nChange: £0 .00\n\nJER MLECZNA KANAP\n\n"

    it 'return 3 values' do
    end
  end

  context 'number with comma and incorrect total word' do
    number_with_comma_and_incorrect_total_and_finish_scan = "MERCI COFFEE&CREAM | £2.65\nMERCI DARK 1006 E2 .85\nSchogetten czekolada £1,55\nSEREK MILANDIA SMIET £1.75\nMINI GOLKA 1606 £3.85\nBURACZKI PAP CEB 460 £1.20\nButchery £1.09\nOREO 30g £0.60\nButchery £1.29\nFruit & Veg 5.50\nFruit & Veg £2.03\nFruit & Veg £2.73\nGrocery £2.99\nlotal :£29\n\nCash: £29.58\nChange :£0.00\n\nYou were served by: Julia\n\n"

    it 'return 3 values' do
    end
  end

  context 'when finish word Items:' do
    without_total_but_items = "I\n\nw\nPolish Marke Jess\n2 Newmarket Road,\n\nCambridge,\n\nCBS gpz\nVAT NO RECEIPT : 145947\nBR:1\\] Julia 17/09/2022 11:38\nMERCI COFFEE&CREAM 1 £2.65\nMERCI DARK 100G £2.85\nSchoget ten czekolada £1.55\nSEREK MILANDIA SMIET £1.75\nMINI GOLKA 1606 £3.35\nBURACZKI PAP CEB 460 £1.20\nButchery £1.09\nOREO 30g £0.60\nButchery £1.29\nFruit & Veg £5.50\nFruit & Veg £2.03\nFruit & Veg £2.73\nGrocery £2.99\nItems: 13 Fotall £29.58\n\nCash: £29 58\nChange :£0 00\n\nyou were served by: Julia\n\n“THANK YOU PLEASE CALL AGAIN\"\n\n“MO Peis) TRA) ODA\n"

    it 'return 3 values' do
    end
  end
end
