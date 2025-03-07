<template>
  <nav>
    <ul>
      <!-- <font-awesome-icon :icon="['fas', 'magnifying-glass']" bounce /> -->
      <font-awesome-icon :icon="['fas', 'magnifying-glass']" beat />
      <font-awesome-icon :icon="['fab', 'github']" />
      <input
        v-model="testQueryInput"
        placeholder="Search for an Item..."
        v-on:keyup.enter="onEnter"
      />
      <p>Item to query for is: {{ testQueryInput }}</p>
      <RouterLink class="right" to="/mappings/all-items">All Items</RouterLink>
      <RouterLink class="right" to="/mappings/FAQs">FAQs</RouterLink>
    </ul>
  </nav>
</template>
