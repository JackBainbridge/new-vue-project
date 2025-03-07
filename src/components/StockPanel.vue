<template>
  <div class="stock-panel">
    <div class="panel-item ticker-item">
      <span class="value ticker">{{ ticker }}</span>
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
  background-color: #f0f0f0;
  border-radius: 10px;
  padding: 20px;
  max-width: 150px;
  transition: transform 0.3s ease;
}

.stock-panel:hover {
  transform: translateY(-5px);
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
  color: var(--green);
}

.negative {
  color: var(--red);
}

.ticker-item {
  text-align: center;
  width: 100%;
}

.ticker {
  font-weight: bold;
  font-size: 120%
}
</style>
