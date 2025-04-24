import { useEffect, useRef } from 'react';

const useDidUpdate = (f, conditions) => {
  const didMountRef = useRef(false);
  useEffect(() => {
    if (!didMountRef.current) {
      didMountRef.current = true;
      return;
    }

    return f && f();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, conditions);
};

export default useDidUpdate;
