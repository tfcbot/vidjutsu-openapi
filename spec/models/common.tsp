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
  @doc("Create account (free)")
  `accounts.create`: int32;

  @doc("Create post (free)")
  `posts.create`: int32;

  @doc("Analyze media (critic/verify/breakdown)")
  analyze: int32;
}
