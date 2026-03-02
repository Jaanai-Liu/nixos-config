let

  lz_pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8B31wZficBJy4Tli3w+C0hsa7uhsMlff43JF6PSYBe liujaanai@gmail.com";
  lz_laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8B31wZficBJy4Tli3w+C0hsa7uhsMlff43JF6PSYBe liujaanai@gmail.com";

  # 把它们都加进列表
  all_keys = [ lz_laptop lz_pc ];
in
{
  "./secrets/test.age".publicKeys = all_keys;
  "./secrets/wifi_lz_phone.age".publicKeys = all_keys;
  "./secrets/ssh-key.age".publicKeys = [ lz_pc my_laptop ];
}
