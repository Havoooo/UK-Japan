# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe JpLocalGov do
  describe ".find" do
    context "the local government code is specified" do
      subject(:result) { JpLocalGov.find(local_gov_code) }

      context "when the code exists" do
        let(:local_gov_code) { "131016" }
        it "returns a single LocalGov record" do
ect(result.city_kana).to eq "チヨダク"
          expect(result.prefecture_capital).to be_falsey
        end
      end

      context "when the code DOES NOT exist" do
        context "when the code is NOT existing code" do
          # NOT existing code is able to generate by check digit defined in JISX0402
          # https://www.soumu.go.jp/main_content/000137948.pdf
          let(:local_gov_code) { "131017" }
          it { is_expected.to be_nil }
        end

        context "when the code is nil" do
          let(:local_gov_code) { nil }
          it { is_expected.to be_nil }
        end

        context "when the code is NOT a string" do
          let(:local_gov_code) { 131_016 }
          it { is_expected.to be_nil }
        end
      end
    end

    end
  end
end

# rubocop:enable Metrics/BlockLength
