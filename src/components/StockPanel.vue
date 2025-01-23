<template>
  <div class="stock-panel">
    <div class="panel-item">
      <span class="value">{{ ticker }}</span>
    </div>
    <div class="panel-item">
      <span class="label">Price:</span>
      <span class="value">{{ formatPrice(price) }}</span>
    </div>
    <div class="panel-item">
      <span class="label">Change Amount:</span>
      <span class="value" :class="{ positive: changeAmount > 0, negative: changeAmount < 0 }">
        {{ formatChangeAmount(changeAmount) }}
      </span>
    </div>
    <div class="panel-item">
      <span class="label">Change Percentage:</span>
      <span
        class="value"
        :class="{ positive: changePercentage > 0, negative: changePercentage < 0 }"
      >
        {{ formatPercentage(changePercentage) }}
      </span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'StockPanel',
  props: {
    ticker: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    changeAmount: {
      type: Number,
      required: true,
    },
    changePercentage: {
      type: Number,
      required: true,
    },

    // Parent methods
    formatPrice: {
      type: Function,
      required: true,
    },
    formatChangeAmount: {
      type: Function,
      required: true,
    },
    formatPercentage: {
      type: Function,
      required: true,
    },
  },
}
</script>

<style scoped>
.stock-panel {
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 5px;
  max-width: 150px;
  background-color: #f9f9f9;
}

.panel-item {
  margin-bottom: 12px;
}

.label {
  font-weight: bold;
  display: block;
  margin-bottom: 4px;
}

.value {
  font-size: 1.1em;
}

.positive {
  color: green;
}

.negative {
  color: red;
}
</style>
