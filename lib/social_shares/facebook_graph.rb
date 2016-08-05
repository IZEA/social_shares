module SocialShares
  class FacebookGraph < Base
    OAUTH_URL = "https://graph.facebook.com/oauth/access_token".freeze
    URL = "https://graph.facebook.com/v2.7/".freeze

    def shares!
      response = get(URL, params: { access_token: access_token, id: checked_url })

      JSON.parse(response)["share"]["share_count"]
    end

  private

    def access_token
      response = get(OAUTH_URL,
        params: { client_id: client_id, client_secret: client_secret, grant_type: "client_credentials" })

      response.sub("access_token=", "")
    end

    def client_id
      (@@config[config_name] || {})[:app_id] || raise("Missing Facebook OAuth credentials")
    end

    def client_secret
      (@@config[config_name] || {})[:app_secret] || raise("Missing Facebook OAuth credentials")
    end
  end
end
