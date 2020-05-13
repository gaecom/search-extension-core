local content_script = {
  new(matches, js, css):: {
    matches: matches,
    js: js,
    css: css,
    run_at: 'document_start',
  },
};

{
  /**
  * @name manifest.new
  */
  new(
    name,
    keyword,
    description,
    version
  ):: {
    local it = self,
    _icons:: {},
    _background_scripts:: [
      'core/compat.js',
      'core/omnibox.js',
      'core/command/base.js',
      'core/command/history.js',
      'core/command/manager.js',
    ],

    manifest_version: 2,
    name: name,
    description: description,
    version: version,
    icons: it._icons,
    browser_action: {
      default_icon: it._icons,
      default_popup: 'popup/index.html',
      default_title: description,
    },
    content_security_policy: "script-src 'self'; object-src 'self';",
    omnibox: {
      keyword: keyword,
    },
    content_scripts: [],
    background: {
      scripts: it._background_scripts,
    },
    web_accessible_resources: [],
    permissions: [
      'tabs',
    ],
    addIcons(i):: self + {
      _icons+: i,
    },
    addPermission(permission):: self + {
      permissions+: [permission],
    },
    appendContentSecurityPolicy(policy):: self + {
      content_security_policy+: policy,
    },
    addWebAccessibleResources(resource):: self + {
      web_accessible_resources+: [resource],
    },
    addBackgroundScript(script):: self + {
      _background_scripts+: script,
    },
    addContentScript(matches, js, css):: self + {
      content_scripts+: [content_script.new(matches, js, css)],
    },
  },
}