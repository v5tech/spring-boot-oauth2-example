DROP TABLE IF EXISTS users;
CREATE TABLE users (
  username VARCHAR(50) NOT NULL PRIMARY KEY,
  password VARCHAR(50) NOT NULL,
  enabled  BOOLEAN     NOT NULL
);

DROP TABLE IF EXISTS authorities;
CREATE TABLE authorities (
  username  VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users (username)
);
CREATE UNIQUE INDEX ix_auth_username
  ON authorities (username, authority);

DROP TABLE IF EXISTS oauth_client_details;
CREATE TABLE oauth_client_details (
  client_id               VARCHAR(255) PRIMARY KEY,
  resource_ids            VARCHAR(255),
  client_secret           VARCHAR(255),
  scope                   VARCHAR(255),
  authorized_grant_types  VARCHAR(255),
  web_server_redirect_uri VARCHAR(255),
  authorities             VARCHAR(255),
  access_token_validity   INTEGER,
  refresh_token_validity  INTEGER,
  additional_information  VARCHAR(4096),
  autoapprove             VARCHAR(255)
);

DROP TABLE IF EXISTS oauth_client_token;
CREATE TABLE oauth_client_token (
  token_id          VARCHAR(255),
  token             VARCHAR(255),
  authentication_id VARCHAR(255) PRIMARY KEY,
  user_name         VARCHAR(255),
  client_id         VARCHAR(255)
);

DROP TABLE IF EXISTS oauth_access_token;
CREATE TABLE oauth_access_token (
  token_id          VARCHAR(255),
  token             VARCHAR(255),
  authentication_id VARCHAR(255) PRIMARY KEY,
  user_name         VARCHAR(255),
  client_id         VARCHAR(255),
  authentication    VARCHAR(255),
  refresh_token     VARCHAR(255)
);

DROP TABLE IF EXISTS oauth_refresh_token;
CREATE TABLE oauth_refresh_token (
  token_id       VARCHAR(255),
  token          VARCHAR(255),
  authentication VARCHAR(255)
);

DROP TABLE IF EXISTS oauth_code;
CREATE TABLE oauth_code (
  code           VARCHAR(255),
  authentication VARCHAR(255)
);

DROP TABLE IF EXISTS oauth_approvals;
CREATE TABLE oauth_approvals (
  userId         VARCHAR(255),
  clientId       VARCHAR(255),
  scope          VARCHAR(255),
  status         VARCHAR(10),
  expiresAt      TIMESTAMP,
  lastModifiedAt TIMESTAMP
);

-- customized oauth_client_details table
DROP TABLE IF EXISTS custom_oauth_client_details;
CREATE TABLE custom_oauth_client_details (
  appId                  VARCHAR(255) PRIMARY KEY,
  resourceIds            VARCHAR(255),
  appSecret              VARCHAR(255),
  scope                  VARCHAR(255),
  grantTypes             VARCHAR(255),
  redirectUrl            VARCHAR(255),
  authorities            VARCHAR(255),
  access_token_validity  INTEGER,
  refresh_token_validity INTEGER,
  additionalInformation  VARCHAR(4096),
  autoApproveScopes      VARCHAR(255)
);