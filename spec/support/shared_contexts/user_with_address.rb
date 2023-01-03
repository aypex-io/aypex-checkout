shared_context "user with address" do
  let(:state) { Aypex::State.all.first || create(:state) }

  let(:address) do
    create(:address, address1: FFaker::Address.street_address, state: state)
  end

  let(:billing) { build(:address, state: state) }
  let(:shipping) do
    build(:address, address1: FFaker::Address.street_address, state: state)
  end

  let!(:user) do
    u = create(:user)
    u.addresses << address
    u.save
    u
  end

  before do
    allow_any_instance_of(Aypex::CheckoutController).to receive_messages(try_aypex_current_user: user)
    allow_any_instance_of(Aypex::AddressesController).to receive_messages(try_aypex_current_user: user)
  end
end
