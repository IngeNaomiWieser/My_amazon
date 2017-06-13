module VotesHelper

  def review_voter(review, vote)

    if vote.nil?
      upvote = link_to fa_icon('chevron-up lg'),
        review_votes_path(review, { is_up: true }),
        method: :post
      downvote = link_to fa_icon('chevron-down lg'),
        review_votes_path(review, { is_up: false }),
        method: :post
    elsif vote.is_up?
      upvote = link_to fa_icon('chevron-up 2x'),
        review_vote_path(review, vote),
        method: :delete
      downvote = link_to fa_icon('chevron-down lg'),
        review_vote_path(review, vote, { is_up: false }),
        method: :patch
    else
      upvote = link_to fa_icon('chevron-up lg'),
        review_vote_path(review, vote, { is_up: true }),
        method: :patch
      downvote = link_to fa_icon('chevron-down 2x'),
        review_vote_path(review, vote),
        method: :delete
    end
    
    content_tag(
      :div,
      [ upvote, review.vote_total, downvote ].join('').html_safe,
      class: 'vote-button'
    )
  end
end
