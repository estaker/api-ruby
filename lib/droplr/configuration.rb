module Droplr
  class Configuration

    attr_accessor :token, :secret, :use_production, :app_public_key, :app_private_key, :user_agent

    # basic client configuration
    DROPLR_PRODUCTION_SERVER_PORT = 443
    DROPLR_DEV_SERVER_PORT        = 8069
    DROPLR_PRODUCTION_SERVER_HOST = "api.droplr.com"
    DROPLR_DEV_SERVER_HOST        = "sandbox.droplr.com"

    # endpoints
    ACCOUNT_ENDPOINT = "/account"
    DROPS_ENDPOINT   = "/drops"
    LINKS_ENDPOINT   = "/links"
    NOTES_ENDPOINT   = "/notes"
    FILES_ENDPOINT   = "/files"

    # allowed values
    EDIT_ACCOUNT_FIELDS = %w(password theme useDomain domain useRootRedirect rootRedirect dropPrivacy firstName lastName useLogo logo)
    LIST_DROPS_PARAMS   = %w(offset amount type sortBy order since until search)
    NOTE_VARIANTS       = %w(markdown textile code plain)

    # json-formatted fields come back as camel-cased, but we want underscored.
    JSON_TO_UNDERSCORE_FIELDS = {
      "sortBy"                    => "sort_by",
      "obscureCode"               => "obscure_code",
      "createdAt"                 => "created_at",
      "fileCreatedAt"             => "file_created_at",
      "lastAccess"                => "last_access",
      "pixelDensity"              => "pixel_density",
      "previewThumb"              => "preview_thumb",
      "previewSmall"              => "preview_small",
      "previewMedium"             => "preview_medium",
      "subscriptionEnd"           => "subscription_end",
      "customerId"                => "customer_id",
      "subscriptionWillAutoRenew" => "subscription_will_auto_renew",
      "willAutoRenew"             => "will_auto_renew",
      "dropPrivacy"               => "drop_privacy",
      "ownerIsPro"                => "owner_is_pro",
      "extraSpace"                => "extra_space",
      "totalSpace"                => "total_space",
      "usedSpace"                 => "used_space",
      "useDomain"                 => "use_domain",
      "dropCount"                 => "drop_count",
      "maxUploadSize"             => "max_upload_size",
      "useRootRedirect"           => "use_root_redirect",
      "rootRedirect"              => "root_redirect",
      "activeDrops"               => "active_drops",
      "referrerEmail"             => "referrer_email",
      "teamAdmin"                 => "team_admin",
      "useSubdomain"              => "use_subdomain",
      "teamName"                  => "team_name",
      "teamId"                    => "team_id",
      "useLogo"                   => "use_logo",
      "firstName"                 => "first_name",
      "lastName"                  => "last_name",
      "freeDrops"                 => "free_drops",
      "freeDropLimit"             => "free_drop_limit",
      "referrerCustomerId"        => "referrer_customer_id",
      "referrerReferralCount"     => "referrer_referral_count",
      "referralCount"             => "referral_count",
      "referrerWasReferred"       => "referrer_was_referred",
      "selfDestructTime"          => "self_destruct_time",
      "selfDestructViews"         => "self_destruct_views"
    }

    UNDERSCORE_TO_JSON_FIELDS = JSON_TO_UNDERSCORE_FIELDS.invert

    def initialize(options)
      options.each do |key, value|
        self.send "#{key}=", value
      end
    end

    # implement our own attr_accessor_with_default setup here so we can fall back
    # to anonymous credentials
    def use_production
      @use_production ||= @use_production.nil? ? true : @use_production
    end

    def use_production=(value)
      @use_production = value
    end

    def base_url
      "#{protocol}://#{host}:#{port}/"
    end

  private

    def protocol
      use_production ? "https" : "http"
    end

    def port
      use_production ? DROPLR_PRODUCTION_SERVER_PORT : DROPLR_DEV_SERVER_PORT
    end

    def host
      use_production ? DROPLR_PRODUCTION_SERVER_HOST : DROPLR_DEV_SERVER_HOST
    end

  end
end