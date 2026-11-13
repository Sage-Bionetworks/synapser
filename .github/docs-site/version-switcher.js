// Adds a floating version picker to the home page of a docs version
// (<site>/<version>/index.html).
//
// The docs workflow publishes this file at the site root, next to
// versions.json, and docs_versions.py adds
//   <script src="../version-switcher.js" defer></script>
// to each version's index.html, old releases included. The list of versions
// is read from versions.json when the page opens, so a new release shows up
// on every page without rebuilding the older ones.
(function () {
  "use strict";

  // this file and versions.json both live at the site root
  var script = document.currentScript;
  if (!script || !script.src) return;
  var siteRoot = new URL("./", script.src);
  // the folder this page is in, e.g. https://.../latest/
  var here = new URL("./", window.location.href).href;

  fetch(new URL("versions.json", siteRoot))
    .then(function (response) {
      if (!response.ok) throw new Error("versions.json: " + response.status);
      return response.json();
    })
    .then(function (versions) {
      if (!versions.length) return;
      render(versions);
    })
    .catch(function () {
      // without the list the docs still work, there is just no picker
    });

  function render(versions) {
    var style = document.createElement("style");
    style.textContent =
      ".sv-box{position:fixed;right:16px;bottom:16px;z-index:2000;display:flex;" +
      "align-items:center;gap:8px;padding:8px 12px;font:14px/1.2 system-ui,-apple-system,sans-serif;" +
      "color:#1f2933;background:#fff;border:1px solid #d9dfe5;border-radius:10px;" +
      "box-shadow:0 2px 12px rgba(16,24,40,.15)}" +
      ".sv-box label{margin:0;color:#616e7c;font-weight:600}" +
      ".sv-box select{max-width:11rem;padding:4px 6px;font:inherit;color:inherit;" +
      "background:#fff;border:1px solid #d9dfe5;border-radius:6px;cursor:pointer}";
    document.head.appendChild(style);

    var box = document.createElement("div");
    box.className = "sv-box";

    var label = document.createElement("label");
    label.htmlFor = "sv-select";
    label.textContent = "Version";

    var select = document.createElement("select");
    select.id = "sv-select";

    var found = false;
    versions.forEach(function (v) {
      var option = document.createElement("option");
      option.value = new URL(v.path, siteRoot).href;
      option.textContent = v.name;
      if (option.value === here) {
        option.selected = true;
        found = true;
      }
      select.appendChild(option);
    });

    // a page whose folder is not in versions.json (say a release that was
    // left out of the list) still shows where the reader is
    if (!found) {
      var current = document.createElement("option");
      current.value = here;
      current.textContent = here.replace(/\/$/, "").split("/").pop();
      current.selected = true;
      select.insertBefore(current, select.firstChild);
    }

    select.addEventListener("change", function () {
      if (select.value) window.location.href = select.value;
    });

    box.appendChild(label);
    box.appendChild(select);
    document.body.appendChild(box);
  }
})();
