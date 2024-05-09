window.customElements.define(
  "elm-portal",
  class extends HTMLElement {
    // Base custom element stuff
    constructor() {
      super();
      this._targetNode = document.createElement("div");
    }

    connectedCallback() {
      // Fixes an issue where `<elm-portal>` renders before
      // its target node, and fails to mount.
      // (This function will retry up to 3 times)
      this.attemptToAppend(3);
    }

    attemptToAppend(retries) {
      if (this.target) {
        this.target.appendChild(this._targetNode);
        this.target._portal = this;

        // switch (this.getAttribute("data-mode")) {
        //   case "tooltip":
        //     this.handleTooltipMode();
        //     break;

        //   case "popup":
        //     this.handlePopupMode();
        //     break;

        //   default:
        //   // A non-specific elm-portal
        // }
      } else if (retries > 0) {
        window.requestAnimationFrame(() => this.attemptToAppend(retries - 1));
      }
    }

    get target() {
      if (!this._cachedTarget) {
        const targetId = this.getAttribute("data-elm-portal-target-id");

        if (!targetId) {
          throw "data-elm-portal-target-id is not defined";
        }

        this._cachedTarget = nearestNodeWithId(this, targetId);
      }

      return this._cachedTarget;
    }

    disconnectedCallback() {
      if (this.target) {
        this.target.removeChild(this._targetNode);
      }
    }

    // Re-implementations of HTMLElement functions
    get childNodes() {
      return this._targetNode.childNodes;
    }

    replaceData(...args) {
      return this._targetNode.replaceData(...args);
    }

    removeChild(...args) {
      return this._targetNode.removeChild(...args);
    }

    insertBefore(...args) {
      return this._targetNode.insertBefore(...args);
    }
    appendChild(...args) {
      // To cooperate with the Elm runtime
      requestAnimationFrame(() => {
        return this._targetNode.appendChild(...args);
      });
    }
  },
);

function nearestNodeWithId(el, id) {
  for (const sibling of getAllSiblings(el)) {
    if (sibling.getAttribute("data-elm-portal-id") === id) {
      return sibling;
    }
  }

  if (el.parentElement) {
    return nearestNodeWithId(el.parentElement, id);
  }

  return null;
}

function getAllSiblings(el) {
  const siblings = [];
  let sibling = el?.parentNode?.firstChild;
  if (sibling) {
    do {
      // text node
      if (sibling.nodeType !== 3) {
        siblings.push(sibling);
      }
    } while ((sibling = sibling.nextSibling));
  }

  return siblings;
}
