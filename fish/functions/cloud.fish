function _cloud_show
  test -n "$HEROKU_CLOUD"; and echo "HEROKU_CLOUD => $HEROKU_CLOUD"
  test -n "$ION_HOST"; and echo "ION_HOST => $ION_HOST"
  test -n "$HEROKU_HOST"; and echo "HEROKU_HOST => $HEROKU_HOST"
  test -n "$HEROKU_API_URL"; and echo "HEROKU_API_URL => $HEROKU_API_URL"
  test -n "$HEROKU_STATUS_HOST"; and echo "HEROKU_STATUS_HOST => $HEROKU_STATUS_HOST"
  test -n "$USE_PUBLIC_IP"; and echo "USE_PUBLIC_IP => $USE_PUBLIC_IP"
  test -n "$HEROKU_APPDOMAIN"; and echo "HEROKU_APPDOMAIN => $HEROKU_APPDOMAIN"
  test -n "$HEROKU_LOGIN_HOST"; and echo "HEROKU_LOGIN_HOST => $HEROKU_LOGIN_HOST"

  return 0
end

function _cloud_reset
  # Delete existing env vars
  set -u ION_HOST
  set -u ION_DOMAIN
  set -u HEROKU_CLOUD
  set -u HEROKU_HOST
  set -u HEROKU_API_URL
  set -u HEROKU_STATUS_HOST
  set -u USE_PUBLIC_IP
  set -u HEROKU_APPDOMAIN
  set -u HEROKU_LOGIN_HOST

  return 0
end

function cloud
  set c "$argv"
  if test -z $c
    _cloud_show
    return 0
  end

  switch $c
    case default production prod
      _cloud_reset
      set -xg HEROKU_CLOUD production
      set -xg HEROKU_APPDOMAIN herokuapp.com
    case va01 va02 va03 va04 va05 va06 ie01 ie02 qa01 st01
      _cloud_reset
      set -xg HEROKU_CLOUD $c
      set -xg ION_HOST ion-$c.runtime.herokai.com
      set -xg HEROKU_APPDOMAIN herokuapp.com
    case ops
      _cloud_reset
      set -xg HEROKU_CLOUD ops
      set -xg ION_HOST ion-ops.herokai.com
      set -xg HEROKU_HOST ops.herokai.com
    case staging
      _cloud_reset
      set -xg HEROKU_CLOUD staging
      set -xg ION_HOST ion-staging.herokai.com
      set -xg HEROKU_HOST staging.herokudev.com
      set -xg HEROKU_APPDOMAIN staging.herokuappdev.com
      set -xg HEROKU_LOGIN_HOST https://auth-staging-cloud.herokai.com
    case eu-west-1-a, eu
      _cloud_reset
      set -xg HEROKU_CLOUD eu-west-1-a
      set -xg ION_HOST ion-eu-west-1-a.herokai.com
    case us-west-2
      _cloud_reset
      set -xg HEROKU_CLOUD us-west-2
      set -xg ION_HOST ion-us-west-2.herokai.com
      set -xg HEROKU_HOST us-west-2.herokudev.com
    case ops-staging
      _cloud_reset
      set -xg HEROKU_CLOUD ops-staging
      set -xg ION_HOST ion-ops-staging.herokai.com
    case 9 nine
      echo "I'm doing fine, up here on cloud nine"
      echo
      echo "Unknown Cloud"
      return 1
    case '*'
      echo "Unknown Cloud"
      return 1
  end

  test -n "$ION_HOST"; and set -x ION_DOMAIN $ION_HOST
  test -n "$HEROKU_HOST"; and set -x HEROKU_API_URL "https://api.$ION_HOST"

  _cloud_show
end
