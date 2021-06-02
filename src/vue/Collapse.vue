<template>
  <div>
    <button
      v-if="collapsible"
      type="button"
      class="flex focus:outline-none text-left"
      :class="headerClass"
      @click="toggle"
    >
      <span
        class="transition ease-in-out duration-200 transform"
        :class="isExpanded ? 'rotate-90 ' : 'rotate-0 ' + iconClass"
      >
        <slot name="icon" />
      </span>
      <slot name="header" />
    </button>
    <div v-else class="flex focus:outline-none text-left" :class="headerClass">
      <span
        class="transition ease-in-out duration-200 transform"
        :class="isExpanded ? 'rotate-90 ' : 'rotate-0 ' + iconClass"
      >
        <slot name="icon" />
      </span>
      <slot name="link" />
    </div>
    <transition
      enter-active-class="transition ease-out duration-200"
      enter-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition ease-in duration-150"
      leave-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div v-show="isExpanded" :class="contentClass">
        <slot name="content" />
      </div>
    </transition>
  </div>
</template>
<script>
export default {
  props: {
    collapsible: {
      type: Boolean,
      default: true
    },
    headerClass: {
      type: String,
      default: ''
    },
    iconClass: {
      type: String,
      default: ''
    },
    contentClass: {
      type: String,
      default: ''
    },
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isExpanded: this.visible
    };
  },
  methods: {
    toggle: function () {
      this.isExpanded = !this.isExpanded;
    }
  }
};
</script>
