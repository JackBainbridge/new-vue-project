<template>
  <button
    class="circular-button"
    :class="{ left: direction === 'left', right: direction === 'right' }"
    @click="$emit('click')"
    :disabled="disabled"
  >
    <font-awesome-icon v-if="direction === 'left'" :icon="['fas', 'arrow-left']" class="arrow" />
    <font-awesome-icon v-else :icon="['fas', 'arrow-right']" class="arrow" />
  </button>
</template>

<script>
export default {
  name: 'CircularArrowButton',
  props: {
    direction: {
      type: String,
      required: true,
      validator: (value) => ['left', 'right'].includes(value),
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  emits: ['click'],
}
</script>

<style scoped>
.circular-button {
  width: 50px;
  height: 50px;
  background-color: var(--grey);
  color: var(--white);
  border: none;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  box-shadow: 5px 5px 5px var(--black);
  transition:
    transform 0.3s ease,
    background-color 0.3s ease;
}

.circular-button:hover:not(:disabled) {
  background-color: var(--green);
  transform: scale(1.2);
}

.circular-button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.arrow {
  display: inline-block;
  width: 1;
  height: 1;
}
</style>
