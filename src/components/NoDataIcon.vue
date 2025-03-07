<template>
    <div class="no-data-icon">
        <font-awesome-icon :icon="['fas', 'circle-exclamation']" />
      <p>No data available</p>
    </div>
</template>
  
<style scoped>
.no-data-icon {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 200px;
    color: var(--white);
}
</style>
  