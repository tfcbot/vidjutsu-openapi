using Http;

namespace VidJutsu;

model Tag {
  key: string;
  value: string;
}

model ApiError {
  error: string;
  message: string;
  setup?: string;
}

model CreditCosts {
  @doc("Create draft account (free)")
  `accounts.create`: int32;

  @doc("Provision account via TokPortal")
  `accounts.provision`: int32;

  @doc("Create draft post (free)")
  `posts.create`: int32;

  @doc("Schedule post for publishing")
  `posts.schedule`: int32;

  @doc("Analyze media (critic/verify/breakdown)")
  analyze: int32;

  @doc("Scrape creator data")
  scrape: int32;
}

model BreakdownItem {
  label: string;
  amount: int32;
}
