class User < ApplicationRecord

  def self.search(string)
    where("first_name ILIKE ?", "%#{string}%").or(
    where("last_name ILIKE ?", "%#{string}%").or(
    where("email ILIKE ?", "%#{string}%"))).order(first_name: :asc)
  end

  def self.search_not(string)
    where("first_name NOT ILIKE ?", "%#{string}%")
    .where("last_name NOT ILIKE ?", "%#{string}%").order(id: :asc)
  end

end
